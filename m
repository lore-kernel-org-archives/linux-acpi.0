From: =?UTF-8?Q?Ognjen_Gali=C4=87?= <smclt30p@gmail.com>
Subject: Re: [PATCH v2] thinkpad_acpi: Support the battery wear control
Date: Sat, 9 Dec 2017 11:29:51 +0100
Message-ID: <CALgTWSsK+FoHb4PW8iTXHAGK_SXRy=wysfp5cvw7N8AJaaQ+ng@mail.gmail.com>
References: <20171203225640.GA11655@thinkpad> <3171660.sUGE0a2FEN@aspire.rjw.lan>
 <20171204195524.GA25730@thinkpad> <20171209100307.GA8699@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20171209100307.GA8699@amd>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On 09/12/2017, Pavel Machek <pavel@ucw.cz> wrote:
> In newer series (I can't find it at the moment, sorry)

The new series is a 3-patch patchset that obsoletes this
patch. It is in the testing stage and will be pushed to
the mailing lists and maintainers in a few days.

> Maybe we should have separate status "not charging due to wear
> control"?

No, because the ACPI battery driver is a extension to the generic
power supply driver, that does not understand the battery wear control.
Also, Rafael specifically noted NOT to include any thinkpad_acpi-specific
behavior to the generic drivers.

That behavior you are describing can be implemented in the userspace.

Thanks for the time!
Ognjen
