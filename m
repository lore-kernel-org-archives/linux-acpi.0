From: Simon Foster <s.d.f-FhtRXb7CoQBt1OO0OYaSVA@public.gmane.org>
Subject: C-States on Inspiron 6000
Date: Mon, 07 Nov 2005 17:57:57 +0000
Message-ID: <1131386277.16106.19.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
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
List-Id: linux-acpi@vger.kernel.org

I'm experiencing problems with ACPI C-States higher than 1 an Inspiron
6000. At any higher setting Xorg graphics are choppy and input from the
touch-pad is not recognized correctly (e.g. button clicks only register
as half-clicks or don't register at all). If I set max_cstate to 1, the
problems disappear, although the CPU is about 6 degrees hotter at rest
than max_cstate=4. At max C-State 1 the CPU is idle, but at higher max
C-States it displays constant spikes.

The problem occurs on both Gentoo 2.6.13 and 2.6.14. This problem is
always reproducible, by simply changing the max_cstate setting from 1 to
2.

(Please CC me replies).

Thanks,

-Si.



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
