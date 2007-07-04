From: Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org>
Subject: Re: [PATCH 3/3] ACPI autoloading - Create
	__mod_acpi_device_table symbol for all acpi drivers.
Date: Wed, 4 Jul 2007 16:33:42 +0900
Message-ID: <20070704073342.GC8338@inferi.kami.home>
References: <1182112047.4204.12.camel@noname>
	<20070620170617.GA3226@inferi.kami.home>
	<1182361643.28514.708.camel@queen.suse.de>
	<200707030315.33526.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200707030315.33526.lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi4asus-user <acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, trenn-l3A5Bk7waGM@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 03, 2007 at 03:15:33AM -0400, Len Brown wrote:
> 
> > BTW: I also saw a laptop (IIRC it was a sony) with asus and sony ACPI
> > device.
> > When both drivers got loaded things broke.
> > A solution was to only let the asus driver get active if the device is
> > known. Currently, not sure whether still (I sent a patch a while ago),
> > the Asus driver falls back to a default ("M6N"?) configuration. IMO this
> > is a bit too dangerous and instead a message like "unsupported ASUS
> > model found, please send acpidump to linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org".
> 
> This is pretty scary.
> Can you drop the acpidump output into a bugzilla?

and add myself to the cc-list?

thanks
-- 
mattia
:wq!

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
