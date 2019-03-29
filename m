From: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH 00/23] Include linux ACPI docs into Sphinx TOC tree
Date: Fri, 29 Mar 2019 08:08:50 +0800
Message-ID: <20190329000849.mwwktjbllqzwytcz@mail.google.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
 <158b68a902139066f53d308cc5a428774445a05b.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <158b68a902139066f53d308cc5a428774445a05b.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Changbin Du <changbin.du@gmail.com>, Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 28, 2019 at 09:34:50AM -0700, Joe Perches wrote:
> On Fri, 2019-03-29 at 00:26 +0800, Changbin Du wrote:
> > Hi Corbet and All,
> > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > from reStructuredText files. I converted most of the Linux ACPI docs to rst
> > format in this serias.
> []
> >  ...pio-properties.txt => gpio-properties.rst} |  76 +++--
> 
> Please also update this MAINTAINERS entry
>
sure.

> MAINTAINERS-GPIO ACPI SUPPORT
> MAINTAINERS-M:  Mika Westerberg <mika.westerberg@linux.intel.com>
> MAINTAINERS-M:  Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> MAINTAINERS-L:  linux-gpio@vger.kernel.org
> MAINTAINERS-L:  linux-acpi@vger.kernel.org
> MAINTAINERS-S:  Maintained
> MAINTAINERS:F:  Documentation/acpi/gpio-properties.txt
> MAINTAINERS-F:  drivers/gpio/gpiolib-acpi.c
> MAINTAINERS-
> 
> 

-- 
Cheers,
Changbin Du
