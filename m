From: Michael Grigoriev <mag-wxkiEGMmYARAfugRpC6u6w@public.gmane.org>
Subject: Power off does not work when connected to AC (was: S4/S5 wake up immediately)
Date: Mon, 20 Sep 2004 19:22:23 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2004.09.20.23.22.22.309738@luminal.org>
References: <pan.2004.09.02.22.46.23.624873@luminal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 02 Sep 2004 15:46:25 -0700, Michael Grigoriev wrote:
> My laptop (HP ZT3000 series) does not seem to be able to reliably enter S4
> and S5 states anymore. It used to work with 2.6.7-mm2, but with
> 2.6.8.1-mm2 and 2.6.9-rc1 + acpi-20040816, it powers down (harddrive
> clicks off, leds go out, etc), but then turn back on right away.

The problem persists with 2.6.9-rc2-mm1.
I have since determined that power off consistently works when running on
battery power, but not when connected to AC, in which case it simply
reboots. 

Any ideas?

-- 
Have fun,                        "This day has altered my perception
Michael "mag" Grigoriev         I'll never see things quite the same
mag-wxkiEGMmYARAfugRpC6u6w@public.gmane.org                    All that I knew was misconception
http://www.luminal.org             But all of that's about to change"



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
