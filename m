From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 02/57] docs: acpi: convert text files to ReST
Date: Tue, 16 Apr 2019 06:54:44 -0300
Message-ID: <20190416065444.2460d3a3@coco.lan>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
        <10802a7ac16958a2786c2fc083fb5cb50eb7ebb9.1555382110.git.mchehab+samsung@kernel.org>
        <CAJZ5v0hZK07zQzmD6J0J5dBUAecpE_31_W5Ade5UpWrsWBeU+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hZK07zQzmD6J0J5dBUAecpE_31_W5Ade5UpWrsWBeU+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Em Tue, 16 Apr 2019 10:17:11 +0200
"Rafael J. Wysocki" <rafael@kernel.org> escreveu:

> On Tue, Apr 16, 2019 at 5:02 AM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> >
> > Most of the files are already in good shape, making easier to
> > convert them to ReST by adding proper title markups and
> > addressing some identation and markups to properly format the
> > document.  
> 
> There is concurrent work on this under way, please see
> https://marc.info/?t=155381845300002&r=2&w=2
> 
> I'd prefer that one to continue, honestly.

Agreed. I didn't notice the patchset.

Btw, please notice patch 11/57:

	Subject: [PATCH 11/57] docs: extcon: move it to acpi dir and convert it to ReST

IMO, it makes sense to move the extcon driver to ACPI, as it sounds
to be just another ACPI driver.

Thanks,
Mauro
