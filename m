From: Daniel Hoffend <mail-nf-Mmb7MZpHnFY@public.gmane.org>
Subject: Battery charging state: unknown
Date: Thu, 7 Nov 2002 22:56:43 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021107215642.GA1886@intranet.fresh-style.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello 

i have compiled my kernel (2.4.19) with the current patch
(acpi-20021022-2.4.19.diff.gz). The /proc/acpi/battery/BAT1/state shows
that there is an unknown charging stage, but when i remove the power 
supply of my Toshiba Notebook, then it turned to "discharging".


Power Supply on:
###################################
`cat /proc/acpi/battery/BAT1/state`
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mA
remaining capacity:      4000 mAh
present voltage:         14800 mV


Power Supply off:
###################################
`cat /proc/acpi/battery/BAT1/state`
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            0 mA
remaining capacity:      3960 mAh
present voltage:         14800 mV


what is wrong ? is this a known problem, or has somebody a fix or patch
for it. 

Could this be one problem that my notebook doesn't switch to lower CPU
Speed?  (Intel Speedstep) the only possibility at this moment is for me
to set the Speed manually  via cpufreq patch. But there must be a
solution? 

Can somebody help me?

-- 
thanks

Daniel "Griffon" Hoffend




-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
