From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Thu, 20 Apr 2006 15:30:53 -0400
Message-ID: <d120d5000604201230y48493995l1bb13d01a8122e11@mail.gmail.com>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com>
	 <20060420073713.GA25735@srcf.ucam.org>
	 <4447AA59.8010300@linux.intel.com>
	 <20060420153848.GA29726@srcf.ucam.org>
	 <4447AF4D.7030507@linux.intel.com>
	 <1145549460.23837.156.camel@capoeira>
	 <4447B7D6.4030401@linux.intel.com>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.194]:55638 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751045AbWDTTay convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2006 15:30:54 -0400
Received: by nz-out-0102.google.com with SMTP id 40so229700nzk
        for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2006 12:30:54 -0700 (PDT)
In-Reply-To: <4447B7D6.4030401@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Xavier Bestel <xavier.bestel@free.fr>, Matthew Garrett <mjg59@srcf.ucam.org>, "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 4/20/06, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com> wrote:
> Xavier Bestel wrote:
> > There are keyboards with power/sleep buttons. It makes sense they have
> > the same behavior than ACPI buttons.
> Agree, make them behave like ACPI buttons -- remove them from input stream, as they do not belong there...

What if there is no ACPI? What if I want to remap the button to do
something else? Input layer is the proper place for them.

--
Dmitry
