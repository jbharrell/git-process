# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'git-process/git_logger'
require 'git-process/git_branch'
require 'git-process/git_branches'
require 'git-process/git_status'
require 'git-process/git_process_error'


class String

  def to_boolean
    return false if self == false || self.nil? || self =~ (/(false|f|no|n|0)$/i)
    return true if self == true || self =~ (/(true|t|yes|y|1)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end

end


class NilClass
  def to_boolean
    false
  end
end


module GitProc

  #
  # Provides Git configuration
  #
  class GitConfig

    def initialize(lib)
      @lib = lib
    end


    def [](key)
      value = config_hash[key]
      unless value
        value = @lib.command(:config, ['--get', key])
        value = nil if value.empty?
        config_hash[key] = value unless config_hash.empty?
      end
      value
    end


    def []=(key, value)
      @lib.command(:config, [key, value])
      config_hash[key] = value unless config_hash.empty?
      value
    end


    def set_global(key, value)
      @lib.command(:config, ['--global', key, value])
      config_hash[key] = value unless config_hash.empty?
      value
    end


    def gitlib
      @lib
    end


    def logger
      gitlib.logger
    end


    def master_branch
      @master_branch ||= self['gitProcess.integrationBranch'] || 'master'
    end


    def remote_master_branch
      remote.master_branch_name
    end


    def integration_branch
      remote.exists? ? remote_master_branch : self.master_branch
    end


    def rerere_enabled?
      re = self['rerere.enabled']
      re && re.to_boolean
    end


    def rerere_enabled(re, global = true)
      if global
        set_global('rerere.enabled', re)
      else
        self['rerere.enabled'] = re
      end
    end


    def rerere_enabled=(re)
      rerere_enabled(re, false)
    end


    def rerere_autoupdate?
      re = self['rerere.autoupdate']
      re && re.to_boolean
    end


    def rerere_autoupdate(re, global = true)
      if global
        set_global('rerere.autoupdate', re)
      else
        self['rerere.autoupdate'] = re
      end
    end


    def rerere_autoupdate=(re)
      rerere_autoupdate(re, false)
    end


    private

    def remote
      gitlib.remote
    end


    def config_hash
      @config_hash ||= {}
    end

  end

end