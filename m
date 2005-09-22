From: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Subject: Re: oops with asus_acpi on P30/P35
Date: Thu, 22 Sep 2005 16:31:55 +0200
Message-ID: <1127399515.13743.88.camel@f100.suse.de>
References: <20050618004506.GE3690@orest.greek0.net>
	 <42C2BA01.2060806@gmx.net> <20050629155015.GB14659@hell.org.pl>
	 <200508191749.18016.mail@hboeck.de> <1124634977.4952.9.camel@nouse.net>
	 <20050921090810.GS22403@orest.greek0.net>
	 <1127309993.26683.15.camel@f100.suse.de>
	 <20050921150851.GU22403@orest.greek0.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050921150851.GU22403-eJYrgmUciHpxYM3rXe3Iuw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Hanno =?ISO-8859-1?Q?B=F6ck?= <mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Wed, 2005-09-21 at 17:08 +0200, Christian Aichinger wrote:

[...]

> PS: Would be nice if you could test my assumption that model->type
> is really ACPI_TYPE_BUFFER on your laptop, by pasting a dmesg
> snippet with that patch applied (should apply to vanilla -rc2):

Actually I do not own the M2E, but the one who has one checked the value
for model->type. It is ACPI_TYPE_BUFFER:

        DEBUG: model->type == 3

See you,

   Timo



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
