From: "Kimball Murray" <kimball.murray@gmail.com>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Wed, 26 Apr 2006 09:56:06 -0400
Message-ID: <bbe04eb10604260656h76064baev4f654a929290d35b@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6466487@hdsmsx411.amr.corp.intel.com>
	 <200604261517.06505.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.226]:55024 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932447AbWDZN4H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Apr 2006 09:56:07 -0400
Received: by wproxy.gmail.com with SMTP id i2so519729wra
        for <linux-acpi@vger.kernel.org>; Wed, 26 Apr 2006 06:56:07 -0700 (PDT)
In-Reply-To: <200604261517.06505.ak@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: "Brown, Len" <len.brown@intel.com>, linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com, natalie.protasevich@unisys.com, linux-acpi@vger.kernel.org

Hi Andi,



On 4/26/06, Andi Kleen <ak@suse.de> wrote:
> On Tuesday 25 April 2006 21:53, Brown, Len wrote:
> > I'd rather see the original irq-renaming patch
> > and its subsequent multiple via workaround patches
> > reverted than to further complicate what is becoming
> > a fragile mess.
>
> Sorry rechecking - i already got the patch now. You want me to drop it again?
>
> I guess we could drop it all, but VIA must still work afterwards.
> How would we do that?
>
> -Andi
>
