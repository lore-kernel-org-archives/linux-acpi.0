From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 10/10] thinkpad-acpi: sync input	device
	EV_SW state directly
Date: Thu, 10 Dec 2009 23:54:58 -0800
Message-ID: <20091211075458.GB30274@core.coreip.homeip.net>
References: <1260322590-5571-1-git-send-email-hmh@hmh.eng.br>
	<1260322590-5571-11-git-send-email-hmh@hmh.eng.br>
	<200912081745.14725.dmitry.torokhov@gmail.com>
	<20091209163041.GA29575@khazad-dum.debian.net>
	<20091209172119.GB4456@core.coreip.homeip.net>
	<20091209203201.GC29575@khazad-dum.debian.net>
	<20091209205926.GD10138@core.coreip.homeip.net>
	<20091210131918.GA18283@khazad-dum.debian.net>
	<20091210185922.GD23717@core.coreip.homeip.net>
	<20091211004602.GB24245@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091211004602.GB24245-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>, Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 10, 2009 at 10:46:02PM -0200, Henrique de Moraes Holschuh wrote:
> On Thu, 10 Dec 2009, Dmitry Torokhov wrote:
> > Right, input_set_abs_params()... No, I don't really want to go through
> > all touchpad, touchscreen and joystick drivers at once, thank you vey
> > much ;) Besides, for the vast majority of uses 0 is the proper initial
> > value for absolute axis.
> 
> Heh.
> 
> > > The only other event that needs initialization are the switches, so I'd
> > > argue that we might as well use my proposed patch, which is specific and
> > > more lightweight, and convert the in-tree drivers to it.  A few might be
> > > missing the before-registering input_event...
> > 
> > As I think about it even more I think we should leave it asd is. You
> 
> It needs to be documented somewhere, at least.
> 

Something like the patch below?

> > > BTW, looking at input.h, wouldn't it be better to force the init functions
> > > to be run before registering the input device, doing a BUG_ON() if they're
> > > misused?
> > 
> > What function are you referring to? Input devices are in useable state
> 
> The ones proposed in this subthread, which shouldn't be used after
> registering.
> 
> > as returned by input_allocate_device().
> 
> Unless, of course, someone screws up verifying if input_alocate_device
> returned NULL...
> 

Then it will crash way before registering, as soon as they try to set
name, phys and so on.. Just not worh it.

-- 
Dmitry

Input: document use of input_event() function

From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>
---

 drivers/input/input.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)


diff --git a/drivers/input/input.c b/drivers/input/input.c
index e097176..6240c7a 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -302,9 +302,15 @@ static void input_handle_event(struct input_dev *dev,
  * @value: value of the event
  *
  * This function should be used by drivers implementing various input
- * devices. See also input_inject_event().
+ * devices to report input events. See also input_inject_event().
+ *
+ * NOTE: input_event() may be safely used right after input device was
+ * allocated with input_allocate_device(), even before it is registered
+ * with input_register_device(), but the event will not reach any of the
+ * input handlers. Such early invocation of input_event() may be used
+ * to 'seed' initial state of a switch or initial position of absolute
+ * axis, etc.
  */
-
 void input_event(struct input_dev *dev,
 		 unsigned int type, unsigned int code, int value)
 {

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
