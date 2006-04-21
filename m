From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Fri, 21 Apr 2006 08:21:03 -0400
Message-ID: <d120d5000604210521h2946f4a8k34c43caa47705577@mail.gmail.com>
References: <554C5F4C5BA7384EB2B412FD46A3BAD13787F2@pdsmsx411.ccr.corp.intel.com>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.197]:55381 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932168AbWDUMVE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Apr 2006 08:21:04 -0400
Received: by nz-out-0102.google.com with SMTP id 40so384553nzk
        for <linux-acpi@vger.kernel.org>; Fri, 21 Apr 2006 05:21:03 -0700 (PDT)
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD13787F2@pdsmsx411.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, Xavier Bestel <xavier.bestel@free.fr>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 4/21/06, Yu, Luming <luming.yu@intel.com> wrote:
> >> > There are keyboards with power/sleep buttons. It makes
> >sense they have
> >> > the same behavior than ACPI buttons.
> >> Agree, make them behave like ACPI buttons -- remove them
> >from input stream, as they do not belong there...
> >
> >What if there is no ACPI? What if I want to remap the button to do
> >something else? Input layer is the proper place for them.
>
> If you define input layer as a universe place to all manual input
> activity,

Yes. If something is related to input it should be integrated into input layer.

> then I agree to port some type of ACPI event into
> input layer.  But it shouldn't be a fake keyboard scancode,
> My suggestion is to have a separate input event type,e.g. EV_ACPI
> for acpi event layer.
>

The point is that it is not a fake scancode. There are keyboards that
have these keys that don't have anything to do with ACPI. That's why
they belong to input layer. The same goes for lid switch - we have
EV_SW that is used by some PDAs.

Note that I am not saying that other ACPI events, like battery status
or device insertion/removal, should be propagated through input layer.
But things that exist even without ACPI should not be ACPI-specific.

--
Dmitry
