From: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH 00/23] Include linux ACPI docs into Sphinx TOC tree
Date: Fri, 29 Mar 2019 08:10:22 +0800
Message-ID: <20190329001020.utauchuqsqt5maww@mail.google.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
 <20190328103902.1084337d@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190328103902.1084337d@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Changbin Du <changbin.du@gmail.com>, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 28, 2019 at 10:39:02AM -0600, Jonathan Corbet wrote:
> On Fri, 29 Mar 2019 00:26:58 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > from reStructuredText files. I converted most of the Linux ACPI docs to rst
> > format in this serias.
> 
> Thanks for doing this.  I've only looked quickly at this point, so I just
> have a couple of high-level comments.
> 
>  - If at all possible, I would really rather this not be placed in the
>    top-level of the document tree.  Things are far too cluttered there
>    already; I would prefer to take stuff out instead.
> 
>    That said, I'm not at this point sure of where I think it should go.
>    We may want to consider splitting it up; some of it appears to be
>    suitable for the driver API manual, while some of it might be best in
>    the admin guide.  And some probably doesn't fit either.  I'll try to
>    ponder on this a bit more.
>
Agree, they should be arranged for different roles of readers.

>  - It would be a good idea to add SPDX tags to the files while you're
>    working through them.
> 
Will add them. Thanks for reviewing.

> Thanks,
> 
> jon

-- 
Cheers,
Changbin Du
