From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 09/63] Documentation: ACPI: move
 method-customizing.txt to firmware-guide/acpi and convert to reST
Date: Wed, 24 Apr 2019 14:53:48 -0300
Message-ID: <20190424145348.0631c8a1@coco.lan>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-10-changbin.du@gmail.com>
        <20190423180316.7f042bc4@coco.lan>
        <20190424162850.g5ripuixdkvvzsjm@mail.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424162850.g5ripuixdkvvzsjm@mail.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Em Thu, 25 Apr 2019 00:28:52 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> On Tue, Apr 23, 2019 at 06:03:16PM -0300, Mauro Carvalho Chehab wrote:
> > Em Wed, 24 Apr 2019 00:28:38 +0800
> > Changbin Du <changbin.du@gmail.com> escreveu:
> >   

> > > +.. note:: Only ACPI METHOD can be overridden, any other object types like
> > > +   "Device", "OperationRegion", are not recognized. Methods
> > > +   declared inside scope operators are also not supported.
> > > +.. note:: The same ACPI control method can be overridden for many times,
> > > +   and it's always the latest one that used by Linux/kernel.
> > > +.. note:: To get the ACPI debug object output (Store (AAAA, Debug)),
> > > +   please run "echo 1 > /sys/module/acpi/parameters/aml_debug_output".  
> > 
> > Hmm... this may work (not sure if Sphinx would warn or not), but it
> > is visually bad on text mode. I would code it, instead, with something 
> > like:
> > 
> > .. note::
> > 
> >     - Only ACPI METHOD can be overridden, any other object types like
> >       "Device", "OperationRegion", are not recognized. Methods
> >       declared inside scope operators are also not supported.
> > 
> >     - The same ACPI control method can be overridden for many times,
> >       and it's always the latest one that used by Linux/kernel.
> > 
> >     - To get the ACPI debug object output (Store (AAAA, Debug)),
> >       please run::
> > 
> > 		echo 1 > /sys/module/acpi/parameters/aml_debug_output
> > 
> > As this would make it visually better on both text and html formats.
> >  
> No warnings given.

Interesting. I'm now wondering if it did the right thing or if it produced
some weird output... Maybe the answer depends on the Sphinx version one
would be using.

> Your suggested style is better so applied it. Thanks!

Thank you!

Thanks,
Mauro
