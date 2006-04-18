From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: PATCH [1/3]: Provide generic backlight support in Asus ACPI driver
Date: Tue, 18 Apr 2006 17:28:37 +0100
Message-ID: <20060418162837.GA16171@srcf.ucam.org>
References: <20060418082952.GA13811@srcf.ucam.org> <20060418161100.GA31763@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750901AbWDRQ2m@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060418161100.GA31763@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Mochel <mochel@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 18, 2006 at 09:11:00AM -0700, Patrick Mochel wrote:

> > +static struct backlight_device *asus_backlight_device;
> > +
> 
> Why is this dynamically allocated? If there is only one per driver, then the
> register() function could take that as a parameter -- instead of passing various
> variable to initialize it with -- and return an error. 

Fair enough.

> > -static int read_brightness(void)
> > +static int read_brightness(struct backlight_device *bd)
> 
> It seems that you're always passing NULL to this. And, if you're not passing NULL,
> aren't you always referencing the single global instance above? 

Yeah, that's a holdover from an earlier version of the backlight 
interface. I'll fix that up.

> > -static void set_brightness(int value)
> > +static int set_brightness(struct backlight_device *bd, int value)
> >  {
> >  	acpi_status status = 0;
> >  
> > +	value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
> > +	/* 0 <= value <= 15 */
> 
> Is there something wrong with:
> 
> 	if (value < 0)
> 		value = 0;
> 	else if (value > 15)
> 		value = 15;

That's just cut and paste from the existing driver code - your version 
makes more sense.

> > -		value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
> > -		/* 0 <= value <= 15 */
> > -		set_brightness(value);
> > +		set_brightness(NULL,value);
> 
> There should be a space between parameters. 

Ok.

> > +	asus_backlight_device = backlight_device_register ("asus_bl", NULL,
> > +							   &asusbl_data);
> > +
> > +	if (IS_ERR (asus_backlight_device)) {
> > +		printk("Unable to register backlight\n");
> 
> Could you print the name of the driver? 

Sure.

> > +		acpi_bus_unregister_driver(&asus_hotk_driver);
> > +		remove_proc_entry(PROC_ASUS, acpi_root_dir);
> 
> If the backlight fails to register, does it mean that these must also fail? 

Hm. Good question. The rest of the driver ought to work even without 
backlight registration, but that sounds like an edge case.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
