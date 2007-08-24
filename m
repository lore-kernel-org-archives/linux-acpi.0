From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: ACPI video extensions - ACPI vendor specific
	drivers vs. video module
Date: Fri, 24 Aug 2007 12:48:25 +0100
Message-ID: <20070824114825.GA12881@srcf.ucam.org>
References: <1187344606.8780.845.camel@queen.suse.de>
	<20070817131853.GA5027@khazad-dum.debian.net>
	<1187941725.3399.32.camel@prodigy.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1187941725.3399.32.camel-fuDLTLi4t9njSbz6xCtQhw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi4asus-user <acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org>, Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, "Zhang,  Rui" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Starikovskiy,  Alexey Y" <astarikovskiy-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Aug 24, 2007 at 09:48:45AM +0200, Thomas Renninger wrote:

> It looks like (as you already mentioned above) BIOS vendors implement
> the video ACPI spec extensions and on longterm this code should vanish
> from the ThinkPad module again and it should be possible to let
> brightness and other video functionality be done by the video module.

Given that there are plenty of Thinkpads out there that don't (and will 
never) usefully implement the ACPI video extension, I don't think 
there's any realistic chance of that. We're going to be stuck with 
vendor-specific interfaces for some time.

> I could imagine that distinguishing can be done through the OSI/_OS (or
> similar, there are two ACPI functions to identify the OS, the old one is
> called from OS telling the BIOS which OS is running, the other one is
> called from BIOS and OS tells which OS are supported IIRC). Maybe if a
> Vista string is in the game, the video extensions are armed...
> Maybe there is a specific function the OS must call to make the video
> extensions work.

I'm not sure there's any especially compelling reason. As long as the 
platform-specific interfaces still work, there's no reason to prefer the 
ACPI interfaces.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
