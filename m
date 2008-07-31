From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: Avoid critical temp shutdowns on
	specific	ThinkPad T4x(p) and R50p
Date: Thu, 31 Jul 2008 10:19:41 -0300
Message-ID: <20080731131941.GA19665@khazad-dum.debian.net>
References: <200807301556.01815.trenn@suse.de>
	<20080730175227.GA13850@khazad-dum.debian.net>
	<200807302103.39536.trenn@suse.de>
	<f62196f50807301339r10bbb17do4bb2345b688011a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f62196f50807301339r10bbb17do4bb2345b688011a3-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Chris Hanson <cph-gcVWojuH27S2kH9Ulgv/9g@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 30 Jul 2008, Chris Hanson wrote:
> I'm wondering if this thread is about something similar to a problem
> I've seen.  My T61p often locks up when the outside temperature is
> high or when it is humid, and the CPU temperature is high (but less
> than 85C).  Is this like the symptom you're addressing?

No.  I can't tell you why your T61p is locking up, it could be either a
hardware, firmware or softare problem.  But it is not an issue with the
termal limits on ACPI.

But DO keep an eye on *all* the thermal readings you get from thinkpad-acpi.
I have seen some ThinkPads with a defective heat sink let the GPU exceed
85=B0C, etc.

You should ask around in the linux-thinkpad ML and the thinkpad forums to
check if others have the same problem.

And, by all means, update your BIOS and EC firmware to the latest.

-- =

  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
