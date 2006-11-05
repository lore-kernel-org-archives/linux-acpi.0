From: Christian <christiand59@web.de>
Subject: Re: [discuss] Linux 2.6.19-rc4: known unfixed regressions (v2)
Date: Sun, 5 Nov 2006 18:32:12 +0100
Message-ID: <200611051832.13285.christiand59@web.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <454AFD01.4080306@linux.intel.com> <20061103155656.GA1000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:9983 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161393AbWKERdC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 5 Nov 2006 12:33:02 -0500
In-Reply-To: <20061103155656.GA1000@redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, Adrian Bunk <bunk@stusta.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Am Freitag, 3. November 2006 16:56 schrieb Dave Jones:
> On Fri, Nov 03, 2006 at 11:25:37AM +0300, Alexey Starikovskiy wrote:
>  > Could this be a problem?
>  > --------------------
>  > ...
>  > CONFIG_ACPI_PROCESSOR=m
>  > ...
>  > CONFIG_X86_POWERNOW_K8=y
>
> Hmm, possibly.  Christian, does it work again if you set them both to =y ?

Yes, it works now! Only the change to CONFIG_ACPI_PROCESSOR=y made it work 
again!

Nice catch ;-)

Thank you very much!
-Christian
