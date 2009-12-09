From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 10/10] thinkpad-acpi: sync input	device
	EV_SW state directly
Date: Wed, 9 Dec 2009 09:21:19 -0800
Message-ID: <20091209172119.GB4456@core.coreip.homeip.net>
References: <1260322590-5571-1-git-send-email-hmh@hmh.eng.br>
	<1260322590-5571-11-git-send-email-hmh@hmh.eng.br>
	<200912081745.14725.dmitry.torokhov@gmail.com>
	<20091209163041.GA29575@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091209163041.GA29575-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 09, 2009 at 02:30:41PM -0200, Henrique de Moraes Holschuh wrote:
> On Tue, 08 Dec 2009, Dmitry Torokhov wrote:
> > On Tuesday 08 December 2009 05:36:30 pm Henrique de Moraes Holschuh wrote:
> > > Before we register the input device, sync the input layer EV_SW state
> > > directly by setting the bitmaps, to avoid issuing a gratuitous event
> > > for the initial state of these switches.
> > > 
> > > I will propose a clean input layer API for this and change the driver
> > > to use it later, but I'd rather get the driver fix in mainline ASAP.
> > > 
> > 
> > Just do input_report_switch() before registering the device, it will do
> > the right thing.
> 
> At device startup, the input core doesn't know the initial state of the
> switch. It assumes the switch is "off" (all bits clear in the sw bitmap).
> 
> input_report_switch() will call input_event(), which will have a 50% chance
> of doing the wrong thing at startup (i.e. issue an event) since it will look
> at the state of the sw bitmap to decide whether to issue an event or not.
> 

It will not propagate events because until you register the device there
won't be any consumers attached to it. So the only thing that will
happen is that it will sync internal state of the device from input core
point of view with the true state of the hardware.

> > Input core guarantees (and will continue doing so) that it is safe to
> > pass events to the device as soon as it was allocated with
> > input_allocate_device().
> 
> Well, there really isn't a transparent way to do this...
> 
> Either you change the core to use the first event reported to init the
> switch and never issue that first event outside the core (we will also have
> to make sure all drivers know they have to issue this initial event), or you
> add an API for the drivers to directly inform the core of the initial state
> of the switches (I have this already written) and check all drivers that
> export EV_SW events to make sure they use the API (I haven't done this yet).

There is already such API, input_event(). See above.

-- 
Dmitry

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
