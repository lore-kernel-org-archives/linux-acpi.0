From: Volker Braun <volker.braun-DqRHhl98DdeAKZTfuerNgRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: BIOS Update: new dsdt for ThinkPadP R51
Date: Wed, 15 Sep 2004 13:01:22 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2004.09.15.17.01.22.31381@physik.hu-berlin.de>
References: <20040915082407.7A5CD83F6@smtp.causaencantada.org>
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
Cc: linux-thinkpad-l7BEYHA5S10i5T99jlK1Sh2eb7JE58TQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

IBM's description of the fix

On Wed, 15 Sep 2004 08:25:02 +0000, Suso Baleato wrote:
> (Fix) (Linux) Hibernation function does not work correctly under the
> partition environment created by lphdisk.

suggests that it only corrects a bug in the APM or maybe ACPI S4_bios
support. Under ACPI, you should use swsusp(2) which writes the suspend
image in the swap space and does not rely on the BIOS.

The DSDT errors are mostly harmless (or did you find any critical error
message in dmesg?), and are automatically worked around by the AML
interpreter.

Did anybody update and find any relevant changes not mentioned in
the changelog?

Volker




-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
