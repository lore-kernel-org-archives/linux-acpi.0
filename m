From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] asus-laptop: add Lenovo SL LenovoCare
	LED support
Date: Thu, 10 Dec 2009 11:09:35 +0100
Message-ID: <20091210100935.GB2446@ucw.cz>
References: <1260257169-7227-1-git-send-email-ike.pan@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1260257169-7227-1-git-send-email-ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ike Panhc <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Corentin Chary <corentin.chary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Rostovtsev <tetromino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue 2009-12-08 15:26:09, Ike Panhc wrote:
> From: Ike Panhc <ikepanhc-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> 
> This patch is to enable the LenovoCare LED support on Lenovo SL laptop. Based
> on the found of the control interface by Alexandre Rostovtsev
> 
> Turn on the LenovoCare LED:
>  (As root privileges) echo 1 > /sys/class/leds/asus\:\:LenovoCare/brightness
> Trun off the LenovoCare LED:
>  (As root privileges) echo 0 > /sys/class/leds/asus\:\:LenovoCare/brightness
> 
> The patch against current checkout of acpi4asus is below.

Is the driver severely misnamed by now? I believe Lenovo and ASUS are
pretty different firms...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
