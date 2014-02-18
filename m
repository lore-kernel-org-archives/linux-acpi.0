From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] Change ACPI IPMI support to "default y"
Date: Wed, 19 Feb 2014 00:26 +0100
Message-ID: <1511662.Ly2fOjCGKz@vostro.rjw.lan>
References: <1392740909-2079-1-git-send-email-matthew.garrett@nebula.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392740909-2079-1-git-send-email-matthew.garrett@nebula.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: minyard@acm.org, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, February 18, 2014 11:28:29 AM Matthew Garrett wrote:
> 
> The ACPI IPMI driver implements IPMI operation region support for the ACPI
> core. Systems that declare ACPI operation regions may reference them at any
> time, including during kernel initialisation. These accesses will fail
> unless the ACPI IPMI driver is present, and undesirable system behaviour
> may result. Set the default to Y in order to encourage distributions and
> users to configure kernels to avoid awkward surprises.

Do you have any examples of problems caused by that or is this just theoretical
at the moment?

Rafael
