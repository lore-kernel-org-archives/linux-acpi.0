From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Fri, 21 Apr 2006 08:56:48 -0400
Message-ID: <d120d5000604210556v5c5493f9g7676926c8f75bd8d@mail.gmail.com>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com>
	 <20060420073713.GA25735@srcf.ucam.org>
	 <4447AA59.8010300@linux.intel.com>
	 <20060420153848.GA29726@srcf.ucam.org>
	 <4447AF4D.7030507@linux.intel.com>
	 <1145549460.23837.156.camel@capoeira>
	 <4447B7D6.4030401@linux.intel.com>
	 <d120d5000604201230y48493995l1bb13d01a8122e11@mail.gmail.com>
	 <1145563624.14595.5.camel@bip.parateam.prv>
	 <44489D58.3090209@linux.intel.com>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.195]:45036 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932219AbWDUM4s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Apr 2006 08:56:48 -0400
Received: by nz-out-0102.google.com with SMTP id 40so390770nzk
        for <linux-acpi@vger.kernel.org>; Fri, 21 Apr 2006 05:56:48 -0700 (PDT)
In-Reply-To: <44489D58.3090209@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Xavier Bestel <xavier.bestel@free.fr>, Matthew Garrett <mjg59@srcf.ucam.org>, "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 4/21/06, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>=
 wrote:
> Xavier Bestel wrote:
> > Le jeudi 20 avril 2006 =E0 15:30 -0400, Dmitry Torokhov a =E9crit :
> >> On 4/20/06, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel=
=2Ecom> wrote:
> >>> Xavier Bestel wrote:
> >>>> There are keyboards with power/sleep buttons. It makes sense the=
y have
> >>>> the same behavior than ACPI buttons.
> >>> Agree, make them behave like ACPI buttons -- remove them from inp=
ut stream, as they do not belong there...
> >> What if there is no ACPI? What if I want to remap the button to do
> >> something else? Input layer is the proper place for them.
> >
> > Err .. that's what I meant, sorry I was not clear. Matthew's soluti=
on
> > looks right.
> If there is no ACPI, you don't have ACPI buttons to remap. Remapping =
power/lid/sleep button is not wise at least, just because you boot once=
 with acpi=3Doff and get unclean shutdown instead of your intended rema=
pped keystroke.
>

I can see that with power button but lid/sleep should be fine really.
And even with power button - "doctor it hurts..."

--
Dmitry
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
