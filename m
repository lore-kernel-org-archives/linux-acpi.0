From: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>
Subject: Re: [PATCH][2.4] acpi S5 poweroff fix
Date: Wed, 30 Apr 2003 12:02:17 -0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <048f01c30f29$7e02bbd0$3746028e@bio.dfo.ca>
References: <20030429181518.96485.qmail@web41601.mail.yahoo.com>
 <Pine.LNX.4.53.0304301628010.4213@dynast.gaugusch.at>
Mime-Version: 1.0
Content-Type: text/plain;	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: "Markus Gaugusch" <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>

> I think that the prevention of S5 is nonsense.
> echo 5 > /dev/hda will screw up your system much more than echo 5 > sleep.
> Root must know what he's doing. I think that the patch should be applied.

Neither Bruno nor I suggested that there's anything wrong with the patch - I
haven't looked at it, and if I had I doubt I would know any more than I learned
from having read Willy's description.  It made sense.  However, the reason Willy
gave for actually wanting to _use_ S5 seemed flawed.

derek
(ps.  I didn't even need to know that I _could_ echo to /dev/hda :-) Ack!!)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
