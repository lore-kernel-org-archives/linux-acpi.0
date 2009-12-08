From: Corentin Chary <corentin.chary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Resend] [PATCH] asus-laptop: add Lenovo SL
	LenovoCare LED support
Date: Tue, 8 Dec 2009 08:43:13 +0100
Message-ID: <71cd59b00912072343g2fe258b6sc495337cdccd169e@mail.gmail.com>
References: <1260257829-7343-1-git-send-email-ike.pan@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1260257829-7343-1-git-send-email-ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ike Panhc <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Rostovtsev <tetromino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 8, 2009 at 8:37 AM, Ike Panhc <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org> wrote:
> Resend because the email address of signed-off is wrong in prior mail
>
> This patch is to enable the LenovoCare LED support on Lenovo SL laptop. B=
ased
> on the found of the control interface by Alexandre Rostovtsev
>
> Turn on the LenovoCare LED:
> =A0(As root privileges) echo 1 > /sys/class/leds/asus\:\:LenovoCare/brigh=
tness
> Trun off the LenovoCare LED:
> =A0(As root privileges) echo 0 > /sys/class/leds/asus\:\:LenovoCare/brigh=
tness
>
> The patch against current checkout of acpi4asus is below.
>
> Signed-off-by: Ike Panhc <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>

Hi,
Is there another method to control that led in _SB.ATKD ?
Could you re-send me some Leveno dsdt (if possible, more than one) ?
Thanks,


-- =

Corentin Chary
http://xf.iksaif.net

---------------------------------------------------------------------------=
---
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
