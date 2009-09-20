From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/3] backlight: Allow drivers to update the core, and
 generate events on changes
Date: Sun, 20 Sep 2009 08:16:56 -0300
Message-ID: <20090920111656.GA6645@khazad-dum.debian.net>
References: <1247587564-27737-1-git-send-email-mjg@redhat.com>
 <20090919232424.GA15200@khazad-dum.debian.net>
 <20090920041554.GA9229@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751697AbZITLba@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090920041554.GA9229@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rpurdie@rpsys.net, lenb@kernel.org, rui.zhang@intel.com, corentincj@iksaif.net
List-Id: linux-acpi@vger.kernel.org

On Sun, 20 Sep 2009, Matthew Garrett wrote:
> On Sat, Sep 19, 2009 at 08:24:24PM -0300, Henrique de Moraes Holschuh wrote:
> > Should the driver notify of *any* changes, even when the user is hitting the
> > "ceiling" or the "floor" and the backlight value didn't really change?
> 
> I'd say yes - the user will expect the UI to appear whenever they hit 
> the button.

Ok.  The thinkpad-acpi changes depends on a large patchset that I should
send to Len today.  After that, I will send the patch that adds brightness
event support.

Are you backlight patches in any tree?  Are them expected to hit mainline
this merge window?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
