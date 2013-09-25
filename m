From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH v3 4/4] thinkpad-acpi: fix handle locate for video and
 query of _BCL
Date: Wed, 25 Sep 2013 16:58:39 -0300
Message-ID: <20130925195839.GB23810@khazad-dum.debian.net>
References: <1380016052-15315-1-git-send-email-aaron.lu@intel.com>
 <1380016052-15315-5-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51898 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750992Ab3IYT6n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Sep 2013 15:58:43 -0400
Content-Disposition: inline
In-Reply-To: <1380016052-15315-5-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <matthew.garrett@nebula.com>, Seth Forshee <seth.forshee@canonical.com>, Lee Chun-Yi <joeyli.kernel@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Igor Gnatenko <i.gnatenko.brain@gmail.com>, Yves-Alexis Perez <corsac@debian.org>, Felipe Contreras <felipe.contreras@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Jani Nikula <jani.nikula@linux.intel.com>, Ben Jencks <ben@bjencks.net>, Steven Newbury <steve@snewbury.org.uk>, James Hogan <james@albanarts.com>, Kamal Mostafa <kamal@canonical.com>, Joerg Platte <jplatte@naasa.net>, Kalle Valo <kvalo@adurom.com>, Martin Steigerwald <Martin@lichtvoll.de>, =?iso-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.co>

On Tue, 24 Sep 2013, Aaron Lu wrote:
> locate handle for ACPI video by HID, the problem is, ACPI video node
> doesn't really have HID defined(i.e. no _HID control method is defined

ACPI video is supposed to attach a virtual HID node (ACPI_VIDEO_HID) to ACPI
video devices so as to keep the non-trivial video device detection logic in
just one place instead of reinventing the wheel in every driver (which is
always a recipe for disaster).

When did that break?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
