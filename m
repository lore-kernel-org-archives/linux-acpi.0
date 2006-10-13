From: "Mathew Brown" <mathewbrown@fastmail.fm>
Subject: Re: Preventing ACPI from Damaging Your CPU
Date: Thu, 12 Oct 2006 21:56:58 -0700
Message-ID: <1160715418.20153.273234357@webmail.messagingengine.com>
References: <1160663160.13196.273175261@webmail.messagingengine.com>
   <20061013012430.GA31911@srcf.ucam.org>
   <1160714475.18692.273233665@webmail.messagingengine.com>
   <20061013045339.GA534@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33967 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750783AbWJME45 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Oct 2006 00:56:57 -0400
Content-Disposition: inline
In-Reply-To: <20061013045339.GA534@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

Thanks.  But is 80C safe for a CPU?  As I mentioned, 70C is considered
dangerous for an Opteron chip.  What type of temperatures can the
Turions and the C2D support?

On Fri, 13 Oct 2006 05:53:39 +0100, "Matthew Garrett"
<mjg59@srcf.ucam.org> said:
> On Thu, Oct 12, 2006 at 09:41:15PM -0700, Mathew Brown wrote:
> > Thanks Matthew.  Just out of curiosity, how did you find out about this
> > feature (forcing the fan at 80C)?  Also, is this specific to HP or do
> > other vendors also support this?  Finally, is 80C safe for the CPU
> > (Intel or AMD?)?  I read that Opteron chips could be damaged if their
> > temperature reaches 70C.  Thanks for your help.
> 
> A certain amount of reverse engineering of HP hardware while I was 
> trying to diagnose some fan problems before. The fan control chip that 
> HP use is pretty standard, so I think there are docs around somewhere.
> 
> -- 
> Matthew Garrett | mjg59@srcf.ucam.org
-- 
  Mathew Brown
  mathewbrown@fastmail.fm

-- 
http://www.fastmail.fm - Send your email first class

