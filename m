From: Dave Jones <davej@redhat.com>
Subject: Re: [discuss] Linux 2.6.19-rc4: known unfixed regressions (v2)
Date: Fri, 3 Nov 2006 10:56:56 -0500
Message-ID: <20061103155656.GA1000@redhat.com>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061103024132.GG13381@stusta.de> <20061103025623.GB8816@redhat.com> <454AFD01.4080306@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753308AbWKCP6H@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <454AFD01.4080306@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Adrian Bunk <bunk@stusta.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Christian <christiand59@web.de>
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 03, 2006 at 11:25:37AM +0300, Alexey Starikovskiy wrote:
 > Could this be a problem?
 > --------------------
 > ...
 > CONFIG_ACPI_PROCESSOR=m
 > ...
 > CONFIG_X86_POWERNOW_K8=y

Hmm, possibly.  Christian, does it work again if you set them both to =y ?

	Dave

-- 
http://www.codemonkey.org.uk
