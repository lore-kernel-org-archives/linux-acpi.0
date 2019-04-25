From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 00/23] Include linux ACPI docs into Sphinx TOC tree
Date: Thu, 25 Apr 2019 10:44:14 +0200
Message-ID: <CAJZ5v0i3iEyn1vBjPkA0X=8h_UrSeTNV_JduJq9qfYpgCOAPjQ@mail.gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424175306.25880-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-gpio@vger.kernel.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
List-Id: linux-acpi@vger.kernel.org

.On Wed, Apr 24, 2019 at 7:54 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> Hi All,
> The kernel now uses Sphinx to generate intelligent and beautiful documentation
> from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
> reST format in this serias.
>
> The hieararchy of ACPI docs are based on Corbet's suggestion:
> https://lkml.org/lkml/2019/4/3/1047
> I did some adjustment according to the content and finally they are placed as:
> Documentation/firmware-guide/acpi/

I'd like to queue up this series, but it is missing a patch to create
Documentation/firmware-guide/acpi/index.rst.

Care to provide one?
