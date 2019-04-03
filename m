From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 00/24] Include linux ACPI docs into Sphinx TOC tree
Date: Wed, 3 Apr 2019 13:36:13 -0600
Message-ID: <20190403133613.13f3fd75@lwn.net>
References: <20190329001135.15847-1-changbin.du@gmail.com>
        <CAJZ5v0gKX9E+U_9eKfTr7pWGH=jxMLz_Jr850-6BcbG3xBz5qg@mail.gmail.com>
        <CAJZ5v0jbCi3Jgn5YXPCP+zgs-O7z-9_3p3XZGvm40_6RDsJqkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jbCi3Jgn5YXPCP+zgs-O7z-9_3p3XZGvm40_6RDsJqkQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Changbin Du <changbin.du@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2 Apr 2019 10:25:23 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> There are ACPI-related documents currently in Documentation/acpi/ that
> don't clearly fall under either driver-api or admin-guide.  For
> example, some of them describe various aspects of the ACPI support
> subsystem operation and some document expectations with respect to the
> ACPI tables provided by the firmware etc.
> 
> Where would you recommend to put them after converting to .rst?

OK, I've done some pondering on this.  Maybe what we need is a new
top-level "hardware guide" book meant to hold information on how the
hardware works and what the kernel's expectations are.  Architecture
information could maybe go there too.  Would this make sense?

If so, I could see a division like this:

Hardware guide
	acpi-lid
	aml-debugger (or maybe driver api?)
	debug (ditto)
	DSD-properties-rules
	gpio-properties
	i2c-muxes

Admin guide
	cppc_sysfs
	initrd_table_override

Driver-API
	enumeration
	scan_handlers

other:
	dsdt-override: find another home for those five lines

...and so on.  I've probably gotten at least one of those wrong, but that's
the idea.

Of course, then it would be nice to better integrate those documents so
that they fit into a single coherent whole...a guy can dream...:)

Thanks,

jon
