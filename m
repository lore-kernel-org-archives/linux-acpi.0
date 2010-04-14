From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Acpi4asus-user] 1005PE's and backlight controls
Date: Wed, 14 Apr 2010 18:26:08 +0100
Message-ID: <20100414172608.GA15965@srcf.ucam.org>
References: <y2g3b2dfeb01004131934x67e23d80vc73dfd6d5af133fa@mail.gmail.com> <t2i9b2b86521004140923x9c1aaa64p867674329ae158af@mail.gmail.com> <20100414164030.GA14758@srcf.ucam.org> <v2vdb599ead1004141014qb02bc808l6aa29c3b5b23de51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <v2vdb599ead1004141014qb02bc808l6aa29c3b5b23de51@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 14, 2010 at 12:14:04PM -0500, Chris Bagwell wrote:

> Does the acpi-video logic not have logic on its own to send key
> events?  So I guess laptops that don't have custom modules to handle
> this type of stuff don't get visual feedback from gnome-power-manager?

It does, but it's dependent upon the firmware sending them.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
