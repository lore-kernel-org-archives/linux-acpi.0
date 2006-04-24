From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Mon, 24 Apr 2006 10:45:31 -0400
Message-ID: <d120d5000604240745i71bd56b8n99b97130388d36f6@mail.gmail.com>
References: <20060419195356.GA24122@srcf.ucam.org>
	 <20060419200447.GA2459@isilmar.linta.de>
	 <20060419202421.GA24318@srcf.ucam.org>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:9451 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750782AbWDXOpc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2006 10:45:32 -0400
Received: by nz-out-0102.google.com with SMTP id 40so986240nzk
        for <linux-acpi@vger.kernel.org>; Mon, 24 Apr 2006 07:45:32 -0700 (PDT)
In-Reply-To: <20060419202421.GA24318@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Pavel Machek <pavel@suse.cz>

On 4/19/06, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Wed, Apr 19, 2006 at 10:04:47PM +0200, Dominik Brodowski wrote:
> > On Wed, Apr 19, 2006 at 08:53:58PM +0100, Matthew Garrett wrote:
> > > +++ a/include/linux/input.h 2006-04-19 20:49:18 +0100
> > > @@ -344,6 +344,7 @@
> > >  #define KEY_FORWARDMAIL            233
> > >  #define KEY_SAVE           234
> > >  #define KEY_DOCUMENTS              235
> > > +#define KEY_LID                    237
> >
> > What about 236?
>
> I sent a patch last month that uses 236 for KEY_BATTERY, so decided not
> to conflict with it.
>

Yes, I still need to apply it.

Matthew, I would recommend not adding KEY_LID but using one of the
switch codes (SW_0?) for the lid.

Richard, on your handhelds what switch would be most similar to
notebook's lid? Should we alias one of the switches to SW_LID?

--
Dmitry
