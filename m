From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Machine no longer enters C3 on 2.6.11-rc1-bk
Date: 20 Jan 2005 23:30:53 -0500
Message-ID: <1106281843.2399.140.camel@d845pe>
References: <20050120104033.GA25889@elf.ucw.cz>
	 <16879.36609.94551.926755@aber.ac.uk> <20050120105911.GF1452@elf.ucw.cz>
	 <41EFBF4B.80206@bartol.udel.edu>  <41EFC117.9050202@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41EFC117.9050202-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-01-20 at 09:32, Rich Townsend wrote:

> Gak, I just read the wiki, and USB was the culprit. But that doesn't 
> explain why I'm not seeing any transitions to C1, even under full load.

This is normal for the current code -- we run C1 16 times and promote,
but if C2 latency is very low, we never demote to C1:

[root@d600 root]#  cat  /proc/acpi/processor/CPU0/power
active state:            C4
max_cstate:              C8
bus master activity:     00000000
states:
 C1: type[C1] promotion[C2] demotion[--] latency[001] usage[00000010] 
 C2: type[C2] promotion[C3] demotion[C1] latency[001] usage[00266192]
 C3: type[C3] promotion[C4] demotion[C2] latency[085] usage[00028664]
*C4: type[C3] promotion[--] demotion[C3] latency[185] usage[00359811]




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
