From: Voluspa <lista1-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
Subject: Re: Fw: Re: 2.6.15-rc5-mm1
Date: Sat, 10 Dec 2005 10:50:11 +0100
Message-ID: <20051210105011.04914263.lista1@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: akpm-3NddpPZAyC0@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, rik-MdmE8JOsREphl2p70BpVqQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On 2005-12-06 15:12:28 Matthew Garrett wrote:
>On Tue, Dec 06, 2005 at 10:17:38AM +0300, Roman I Khimov wrote:
>>
>>    *C1:                  type[C1] promotion[--] demotion[--]
>>    latency[000] usage[00000000]
>
>Yup, that looks like the problem. I've no idea what changed in this 
>area, but without C2 state support heat output will be higher.

Observe that C1 claims to be unused as well. I just compiled the
2.6.15-rc5 proper and have lost my one and only C-state:

root@sleipner:~# diff -Nur dmesg-2.6.14 dmesg-2.6.15-rc5 |grep "power "
-ACPI: CPU0 (power states: C1[C1])

root@sleipner:~# cat /proc/acpi/processor/CPU0/power
active state:            C1
max_cstate:              C8
bus master activity:     00000000
states:
   *C1:                  type[C1] promotion[--] demotion[--]
latency[000] usage[00000000]

The usage field really does get used in 2.6.14 while staying zero in
15-rc5. I suspect this is the culprit (and no, I haven't tried the nocst
boot param):

--quote--
commit 6d93c64803a5fea84839789aae13290419c62d92
Author: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Thu Sep 15 12:19:00 2005 -0400

    [ACPI] Prefer _CST over FADT for C-state capabilities
    
    Note: This ACPI standard compliance may cause regression
    on some system, if they have _CST present, but _CST value
    is bogus. "nocst" module parameter should workaround
    that regression.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5165
    
    Signed-off-by: Venkatesh Pallipadi<venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    (cherry picked from 883baf7f7e81cca26f4683ae0d25ba48f094cc08 commit)
--unquote--

Mvh
Mats Johannesson
--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
