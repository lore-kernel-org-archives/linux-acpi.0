From: Len Brown <lenb@kernel.org>
Subject: Re: Developing ACPI for Linux - March 27, 2007
Date: Thu, 29 Mar 2007 00:33:29 -0400
Message-ID: <200703290033.29208.lenb@kernel.org>
References: <200703271650.16945.lenb@kernel.org> <8f8ff01d0703272210h1242875cs5f00a7d29da14fc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43062 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753043AbXC2Eeq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Mar 2007 00:34:46 -0400
In-Reply-To: <8f8ff01d0703272210h1242875cs5f00a7d29da14fc0@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>, robert.moore@intel.com
Cc: linux-acpi@vger.kernel.org

On Wednesday 28 March 2007 01:10, Alexey Starikovskiy wrote:
> Len,
> We talked about converting ACPICA tree from CVS to git, and didn't
> find a reason for that.
> I think now it's become interesting again. What if you make snapshot
> "git cvsimport" of CVS  ACPICA (Acpi/source) is enough, and make it
> available as all other ACPI git trees you have?
> 
> It is also possible to modify our conversion scripts to work from this
> snapshot, so it will be easy to try modifications on Linux.

Yes, I think we should look into this.

I don't know if it would be acceptable to the folks on kernel.org
to host the tree, since it contains code that is non-linux too,
but I can ask -- or probably we can find a spot on another server.

thanks,
-Len

