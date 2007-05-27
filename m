From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: register input device
Date: Sun, 27 May 2007 08:53:15 -0300
Message-ID: <20070527115315.GA19562@khazad-dum.debian.net>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <11802006651698-git-send-email-hmh@hmh.eng.br> <200705262335.03978.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36941 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751300AbXE0Lxb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 May 2007 07:53:31 -0400
Content-Disposition: inline
In-Reply-To: <200705262335.03978.dtor@insightbb.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org

On Sat, 26 May 2007, Dmitry Torokhov wrote:
> On Saturday 26 May 2007 13:31, Henrique de Moraes Holschuh wrote:
> > Register an input device to send input events to userspace.
> > 
> > This patch is based on a patch by Richard Hughes <hughsient@gmail.com>.
> > 
> > Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> > Cc: Richard Hughes <hughsient@gmail.com>
> 
> Looks OK, however I am curious why you split registration and generating
> input events into 2 patches...

The registration is driver-wide.  The input events are specific for the
hotkey subdriver.  Other subdrivers will also use the input device, etc.

And, unless requested, I really go with small and very obvious patches.
Makes it really, really easy to fix and review.  Of course the rule that
"the driver must compile *and work* fine at every patch set" to keep it
bissect friendly has higher priority.

> >  static struct platform_device *tpacpi_pdev = NULL;
> >  static struct class_device *tpacpi_hwmon = NULL;
> > +static struct input_dev *tpacpi_inputdev = NULL;
> 
> Why do you initialize static variables?  They are guaranteed to be 0/NULL.

Usually just to shut up gcc.  I will try to remove all initializers and see
if gcc 4.1.2 still complains.  If it doesn't, I will remove all of them in
the entire driver.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
