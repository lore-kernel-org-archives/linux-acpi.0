From: Thomas Tuttle <gmane.thinkinginbinary-w1QkCcy0X+Ct7aBEGUsviw@public.gmane.org>
Subject: Re: Resources on fixing DSDT?
Date: Tue, 14 Sep 2004 19:04:54 +0000 (UTC)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <loom.20040914T210119-309@post.gmane.org>
References: <loom.20040913T141300-570@post.gmane.org> <414594F6.7020507@quantentunnel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andreas Dieling <snow@...> writes:
> Thomas Tuttle wrote:
> > I have an Asus M2400Ne with a screwed-up DSDT (some of the methods are
> > renamed to proprietary names--A*** instead of _***--for Asus' proprietary
> > power management stuff) and I have had no luck getting SpeedStep to work on
> > it.  (Everything else works!)  What I need to do is find the methods in the
> > DSDT that are mis-named, re-name them, and patch my kernel to use the
> > custom DSDT.
> 
> Isn't the M24N Centrino based?

Yes...

> So i think you don't need bios support to get your throttling working...
> intel enhanced speedstep should be enough...

Exactly--well it *should*!  The kernel module speedstep-centrino implements 
Enhanced SpeedStep, and neither it nor the ACPI Processor P[ower]-States module 
(stupidly named simply "acpi") will work--I get a "No such device" error when 
modprobing them with BIOS version 0200 and an oops when modprobing them with 
BIOS versions 0202 or 0203.

Any other suggestions?  Does anyone have a really good grasp of either ACPI P-
states or Enhanced SpeedStep who could help me decipher how to match up Asus' 
renamed functions with the real ones?

Please?  I'll throw in a Gmail invite... ;-)

--Thomas Tuttle



-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
