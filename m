From: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Date: Mon, 14 Feb 2005 21:32:11 +0100
Message-ID: <20050214203211.GA8007@ucw.cz>
References: <20050210161809.GK3493@crusoe.alcove-fr> <E1D0dqo-00041G-00@chiark.greenend.org.uk> <20050214105837.GE3233@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214105837.GE3233-KwDxFO93HejPHUqn3ntIkQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>, Matthew Garrett <mgarrett-QGMSyCZBOSwv4zxTlrOuLwNdhmdF6hFW@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Feb 14, 2005 at 11:58:37AM +0100, Stelian Pop wrote:

> > Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org> wrote:
> > 
> > > Privately I've had many positive feedbacks from users of this driver
> > > (and no negative feedback), including Linux distributions who wish
> > > to include it into their kernels. The reports are increasing in number,
> > > it would seem that newer Sony Vaios are more and more incompatible
> > > with sonypi and require sony_acpi to control the screen brightness.
> > 
> > The sonypi driver seems to be necessary to catch Vaio hotkey events,
> > including the sleep button. I've checked a couple of DSDTs, and it seems
> > that the more recent Vaios are lacking the SPIC entries but still don't
> > have the sleep button defined. Is there any chance of this driver being
> > able to catch hotkey events?
> 
> I don't believe so.
> 
> > Related to that, I have a nastyish hack which lets the sonypi driver
> > generate ACPI events whenever a hotkey is pressed. Despite not strictly
> > being ACPI events, this makes it much easier to integrate sonypi stuff
> > with general ACPI support. I'll send it if you're interested.
> 
> Wouldn't be more useful to make the ACPI hotkeys generate an
> input event (like sonypi does) and integrate all this at the input
> level ?
 
Yes, I'd like to see that. The other possible way is have the input
layer generate ACPI events for power-related keys.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
