From: Jan Bernatik <bernatik-nd92eFGgBBntwjQa/ONI9g@public.gmane.org>
Subject: APM, ACPI and DPMS question
Date: Tue, 14 Sep 2004 14:52:16 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4146E980.8040501@kn.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I'm studying ACPI, and I found that:

----------------------------------------------------------------------
You should also be aware of another little glitch I discovered. The 
XFree86 server has an option for DPMS (Energy Star) features. The DPMS 
can states can be one of standby, suspend, off or on. Since the 2.4.x 
kernels cannot suspend to disk, this can cause problems.
----------------------------------------------------------------------
source: http://www.tldp.org/HOWTO/ACPI-HOWTO/daemons.html

I really doesn't understand this. I thought it's just about monitor 
energy, so please could somebody just roughly explain this ?

thanks, have a nice day

Jan Bernatik
-- 
student VUT BRNO - FEEC / Czech Republic
http://www.feec.vutbr.cz

registered user no. 207163 using Debian
icq: 78209478
home: linuxdesktop.kn.vutbr.cz


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
