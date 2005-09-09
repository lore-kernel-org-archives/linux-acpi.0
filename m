From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] [2.6.13-mm2] set IBM ThinkPad extras to default n in Kconfig
Date: Fri, 9 Sep 2005 18:29:14 +0200
Message-ID: <200509091829.15073.ak@suse.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B30048FA292@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751422AbVIIQ3Q@vger.kernel.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30048FA292@hdsmsx401.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: akpm@osdl.org, Borislav Petkov <petkov@uni-muenster.de>, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday 09 September 2005 18:06, Brown, Len wrote:

> I'm not sure what to do here -- what use-model
> should we tune default Kconfig for?

I would just give no default for the platform drivers. They are not 
exactly mission critical. The default stuff is for more for
optons that prevent booting when commonly set wrong etc.

-Andi
