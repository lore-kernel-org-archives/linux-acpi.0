From: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Subject: swsusp and ac status
Date: Wed, 23 Jun 2004 08:26:53 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040623082653.A26014@fermat.unipv.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
I noticed that a change in the ac status is not detected after a swsusp. I
think this should be a known issue; is there any workaround available?

How to reproduce the bad behavior:

- swsuspend when on ac (resp. battery) power
- unplug (resp. plug) the ac adapter when the laptop is off
- resume when on battery (resp. ac) power

Then /proc/acpi/ac_adapter/*/state says "on-line" (resp. "off-line").
A new change in the status is then correctly detected.

I tried different acpi configurations (ac in the kernel or as a module, unload
the ac module before suspending and reload it after resuming...) with no
success.

actual kernel 2.6.7 (same behavior with previous ones), no acpi patch, swsusp2
patch

Same behavior with pm-suspend, swsusp and swsusp2.

Daniele


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
