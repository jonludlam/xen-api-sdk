#
# Copyright (c) Citrix Systems, Inc.
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 
#   1) Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
# 
#   2) Redistributions in binary form must reproduce the above
#      copyright notice, this list of conditions and the following
#      disclaimer in the documentation and/or other materials
#      provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
# OF THE POSSIBILITY OF SUCH DAMAGE.
#

if [ -n "$CTXSIGN" ]
then
    CYGCTX=$(cygpath -u "$CTXSIGN")
    ls -l "$CYGCTX"
    CCSS_TICKET=$("$CYGCTX" --authorise --workerID $HOSTNAME --orchID $HOSTNAME --jobID XenServerWindowsLegacyPVTools_signing --task XenServerAPIBindings-${BUILD_NUMBER})
    export CCSS_TICKET
    "$CYGCTX" --sign --cross-sign --key test-key "$1"
    "$CYGCTX" --end
else
    CYGTOOL=$(cygpath -u C:\\WinDDK\\6001.18001\\bin\\catalog\\signtool.exe)
    $CYGTOOL sign -a -s my -n "Citrix Systems, Inc" -d "$2" -t http://timestamp.verisign.com/scripts/timestamp.dll "$1"
fi
