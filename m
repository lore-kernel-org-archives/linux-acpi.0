From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 00/23] Include linux ACPI docs into Sphinx TOC tree
Date: Thu, 28 Mar 2019 10:39:02 -0600
Message-ID: <20190328103902.1084337d@lwn.net>
References: <20190328162721.26138-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 29 Mar 2019 00:26:58 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> The kernel now uses Sphinx to generate intelligent and beautiful documentation
> from reStructuredText files. I converted most of the Linux ACPI docs to rst
> format in this serias.

Thanks for doing this.  I've only looked quickly at this point, so I just
have a couple of high-level comments.

 - If at all possible, I would really rather this not be placed in the
   top-level of the document tree.  Things are far too cluttered there
   already; I would prefer to take stuff out instead.

   That said, I'm not at this point sure of where I think it should go.
   We may want to consider splitting it up; some of it appears to be
   suitable for the driver API manual, while some of it might be best in
   the admin guide.  And some probably doesn't fit either.  I'll try to
   ponder on this a bit more.

 - It would be a good idea to add SPDX tags to the files while you're
   working through them.

Thanks,

jon
