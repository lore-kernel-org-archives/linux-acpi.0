From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 00/24] Include linux ACPI docs into Sphinx TOC tree
Date: Tue, 2 Apr 2019 10:25:23 +0200
Message-ID: <CAJZ5v0jbCi3Jgn5YXPCP+zgs-O7z-9_3p3XZGvm40_6RDsJqkQ@mail.gmail.com>
References: <20190329001135.15847-1-changbin.du@gmail.com> <CAJZ5v0gKX9E+U_9eKfTr7pWGH=jxMLz_Jr850-6BcbG3xBz5qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gKX9E+U_9eKfTr7pWGH=jxMLz_Jr850-6BcbG3xBz5qg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Changbin Du <changbin.du@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Mar 30, 2019 at 10:41 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Mar 29, 2019 at 1:11 AM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > Hi Corbet and All,
> > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > from reStructuredText files. I converted most of the Linux ACPI docs to rst
> > format in this serias.
>
> First, I appreciated the effort, thanks for your work!
>
> > For you to preview, please visit below url:
> > http://104.238.181.70:8080/kernel-doc/acpi/index.html
>
> So currently all of this appears under Kernel API documentation, but
> the majority of it is not about kernel API.
>
> At least some of it could go under admin-guide IMO.

Jon,

There are ACPI-related documents currently in Documentation/acpi/ that
don't clearly fall under either driver-api or admin-guide.  For
example, some of them describe various aspects of the ACPI support
subsystem operation and some document expectations with respect to the
ACPI tables provided by the firmware etc.

Where would you recommend to put them after converting to .rst?

Cheers,
Rafael
