From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 02/57] docs: acpi: convert text files to ReST
Date: Mon, 22 Apr 2019 10:31:02 -0300
Message-ID: <20190422103102.03f9548a@coco.lan>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
        <10802a7ac16958a2786c2fc083fb5cb50eb7ebb9.1555382110.git.mchehab+samsung@kernel.org>
        <CAJZ5v0hZK07zQzmD6J0J5dBUAecpE_31_W5Ade5UpWrsWBeU+Q@mail.gmail.com>
        <20190416145518.xigzqsawvbrospir@mail.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416145518.xigzqsawvbrospir@mail.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Em Tue, 16 Apr 2019 14:55:19 +0000
Changbin Du <changbin.du@gmail.com> escreveu:

> On Tue, Apr 16, 2019 at 10:17:11AM +0200, Rafael J. Wysocki wrote:
> > On Tue, Apr 16, 2019 at 5:02 AM Mauro Carvalho Chehab
> > <mchehab+samsung@kernel.org> wrote:  
> > >
> > > Most of the files are already in good shape, making easier to
> > > convert them to ReST by adding proper title markups and
> > > addressing some identation and markups to properly format the
> > > document.  
> > 
> > There is concurrent work on this under way, please see
> > https://marc.info/?t=155381845300002&r=2&w=2
> >   
> I will update the serias asap. I am just a little busy these days. My
> conversion includes pci, acpi and x86, others are not touched.

Ok, I sent a new patch series without pci, acpi and x86.

While these aren't merged upstream, I'm keeping my old patches
on my tree:

	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=convert_rst_v2&id=805b16dd336dd3c27733f02ec8164b2a182972a3
	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=convert_rst_v2&id=c950031ccb87ea14ff4c56f2433072d580db3572
	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=convert_rst_v2&id=4f8afce866dcd8067206b3ee493ed0b682694f49

If you find anything there that would be interesting for your 
series, feel free to pick from them. Everything is based on
linux-next.

Thanks,
Mauro
