## README

Example of how to

- start VM
- provision it
- create a virtualenv
- install Albacore basecaller

```bash
vagrant up && vagrant ssh
sh /shared/provosion.sh

# to start individual tasks
ansible-playbook --start-at-task "pip install requirements" /shared/playbook.yml

# enter venv
source /venv/daily/bin/activate

# copy Albacore src to /shared
sudo pip install /shared/ont_albacore-1.2.6-cp35-cp35m-manylinux1_x86_64.whl
# The directory '/home/vagrant/.cache/pip/http' or its parent directory is not
# owned by the current user and the cache has been disabled. Please check the
# permissions and owner of that directory. If executing pip with sudo, you may
# want sudo's -H flag.

# TODO: try pip install --user ...
read_fast5_basecaller.py -h
```
