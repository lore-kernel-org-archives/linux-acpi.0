From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Suggestion for improving the handling of GPE enabling.
Date: Wed, 9 Mar 2005 23:21:24 +0100
Message-ID: <20050309222122.GA32516@elf.ucw.cz>
References: <1110318037.3663.19.camel@desktop.cunningham.myip.net.au> <1110331896.12642.16.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110331896.12642.16.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > better tied to what's actually happening (I'm assuming Pavel's
> > pm_message_t changes are applied). Something like:
> > 
> > PMSG_FREEZE: Disable GPEs.
> > PMSG_SUSPEND: Enable wake GPEs.
> > PMSG_ON: Disable wake GPEs, enable normal GPEs.
> I have the same feeling. A real solution should be to merge ACPI device
> into the global device tree, so every ACPI driver will have a
> .suspend/.resume method. In the .suspend/.resume method, we can do
> anything we want. This has been in the wish list for a long time.
> Some issues are:
> 1. what kind of device should ACPI device be? system device or platform
> device?

I'd say platform device, but pick one ;-).

> 2. What's purpose of the current ACPI namespace in sysfs? Could ACPI
> device be regarded as a normal device?

I did not notice we have ACPI namespace in sysfs... ... aha, I see. I
guess it is okay for debugging and low-level tricks aka sonypi?

> 3. Some ACPI devices have physical partners. Who will do the
> suspend/resume?

I'd let the physical partners do it; it should work without ACPI, too.

> 4. ACPI devices are in many different physical buses. If we just define
> an ACPI bus, we possibly can't show the bus hierarchy.

Maybe ACPI device should be "under" real hardware one?

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
