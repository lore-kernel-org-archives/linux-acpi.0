From: "Carlo E. Prelz" <fluido-1XNsQiTun9D1P9xLtpHBDw@public.gmane.org>
Subject: Re: problems with acpi (sleep states) on vaio notebook z1sp
Date: Tue, 23 Dec 2003 08:26:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031223072658.GN2000@casa.fluido.as>
References: <3ACA40606221794F80A5670F0AF15F8401720C50@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C50-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

	Subject: RE: [ACPI] problems with acpi (sleep states) on vaio notebook z1sp
	Date: Tue, Dec 23, 2003 at 02:34:18PM +0800

Quoting Yu, Luming (luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org):

> 	S3 doesn't resume for your too? So far, I found VARIO z1sp,
> Fujitsu Lifebook S series (6120D), ASUS M2400N cannot resume from S3. 
> 
> 	It looks like a generic problem.

The same happens with my Asus M3700N (centrino). After 
echo 3 > /proc/acpi/sleep, some messages on the screen indicate that
the system is about to go to sleep, and very quickly the screen goes
dark and the blue on-light starts to blink. Then, if I press the on
button again, the on-light turns stable on again, but this is not
followed by a return back to life. If I keep the on-button pressed on
for a long time, the system goes off. But then, when trying to turn it
on again, it attempts to boot for 1 second, and then turns off
again. Only clicking the general reset button (the one you reach from
the bottom of the machine with a pin) brings it back to life.

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido-1XNsQiTun9D1P9xLtpHBDw@public.gmane.org             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
