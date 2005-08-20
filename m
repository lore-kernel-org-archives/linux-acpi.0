From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Thinkpads running hot
Date: Sat, 20 Aug 2005 20:53:48 +0200
Message-ID: <43077C3C.5030501@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I got several reports of Thinkpads shutting down due critical temp limit.
Here are some more:
http://mailman.linux-thinkpad.org/pipermail/linux-thinkpad/2005-August/th=
read.html

I have no idea yet, but it seems as if the fan control does not work as e=
xpected.

I got a good hint that helps a bit for some models (Xorg.conf - graphics =
card tweaking):
____________________________________________________
>Could you please tell me the card and how to solve it
> (just curious)?

ATI FireGL mobility T2, Option "DynamicClocks" "on". This way the tempera=
ture
of the gfx card goes down from ~ 98=B0C to 56=B0C, when idling over night=
 it goes
down to 48=B0C and the fan stops completely.
____________________________________________________


Still when the processor is on load the critical temperature is reached q=
uickly
(1-3 minutes?).

Thinkpads are widespread and I wonder whether others have experienced tha=
t problem
and whether it only exists on current kernels or got it solved somehow.

Thanks,

     Thomas


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
