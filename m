From: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Date: Mon, 14 Feb 2005 13:38:23 +0100
Message-ID: <20050214123822.GF3233@crusoe.alcove-fr>
References: <20050214100738.GC3233@crusoe.alcove-fr> <CKthPPXN.1108383209.9808960.khali@localhost>
Reply-To: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CKthPPXN.1108383209.9808960.khali@localhost>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pekka Enberg <penberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Feb 14, 2005 at 01:13:30PM +0100, Jean Delvare wrote:

> 
> Hi Stelian, all,
> 
> On 2005-02-14, Stelian Pop wrote:
> > I have some interesting information from one user, who noticed that:
> >
> > * pbr is the power-on brightness. It's the brightness that the
> >   laptop uses at power-on time.
> 
> Hey, that makes full sense. After playing around with the debug mode, I
> noticed that the brightness was at the minimum level on next boot. I
> thought it was related to the fact that I didn't have the opportunity
> to stop my system cleanly, but it is indeed possible that I had written
> 0 to pbr before the crash. Will test this evening.
> 
> This reminds me of a related thing I had noticed some times ago but
> couldn't explain back then. Brightness changes made under Linux using
> spicctrl always seemed to be temporary (lost over reboot) while those
> made under Windows on the same laptop were permanent (preserved over
> reboot). Now I have to believe that spicctrl was only changing brt,
> while the Windows tool was probably changing both brt and pbr?
> 
> So, what about either renaming pbr to brightness_default,

something like that, yes.

> or making the
> brightness file dual-valued (several acpi files do that already)?

I don't like much this.

> And I
> guess that the pbr value would need to be limited to the 0-8 range just
> like is done for brt.

Probably, I haven't tested it myself yet, so I don't know.

> > * cdp is the CD-ROM power. Writing 0 to cdp turns off the cdrom in
> >   order to save a bit of power consumption.
> 
> I don't seem to have cdp on my system. Is this something I need to
> manually activate in the driver, or does it simply mean that my laptop
> doesn't support that feature?

sony_acpi doesn't create this node. But if it is supported on your
system you should see 'method: name: GCDP' and 'method: name: SCDP'
in the logs because sony_acpi does enumerate all the methods it
finds for the snc device.

If you see it you can create the cdp entry with a bit of copy&paste
in the driver code...

Stelian.
-- 
Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
