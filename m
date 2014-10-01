From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 3/3] toshiba_acpi: Change HCI/SCI functions return code type
Date: Wed, 01 Oct 2014 03:58:34 +0200
Message-ID: <2951962.6yqkWfcajp@vostro.rjw.lan>
References: <1412044809-3366-1-git-send-email-coproscefalo@gmail.com> <1412044809-3366-4-git-send-email-coproscefalo@gmail.com> <20140930205814.GB47302@vmdeb7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20140930205814.GB47302@vmdeb7>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Azael Avalos <coproscefalo@gmail.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, September 30, 2014 01:58:14 PM Darren Hart wrote:
> On Mon, Sep 29, 2014 at 08:40:09PM -0600, Azael Avalos wrote:
> > Currently the HCI/SCI read/write functions are returning
> > the status of the ACPI call and also assigning the
> > returned value of the HCI/SCI function, however, only
> > the HCI/SCI status is being checked.
> > 
> > This patch changes such functions, returning the value
> > of the HCI/SCI function instead of the ACPI call status,
> > eliminating one parameter, and returning something
> > useful that indeed is being checked.
> > 
> > Signed-off-by: Azael Avalos <coproscefalo@gmail.com>
> 
> Cc linux-acpi
> 
> Rafael,
> 
> This follows a couple patches renaming interfaces and error codes. While
> there is some information to be had in checking for ACPI specific errors, I
> don't think it's significant to warrant asking Azael to go the other way and
> check for them specifically and add errorcodes to the interface rather than
> cleanup the functionality as it stands today and simplifiy the code as he does
> here.
> 
> Any objection?

Nope.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
