From: Kevin O'Connor <kevin@koconnor.net>
Subject: Re: [RFC PATCH] Add _PXM to CPU objects for NUMA hot-plug
Date: Tue, 5 Nov 2013 21:52:39 -0500
Message-ID: <20131106025239.GA18207@morn.localdomain>
References: <1382693530-31137-1-git-send-email-vasilis.liaskovitis@profitbricks.com>
 <20131104105149.GB30503@dhcp-192-168-178-175.profitbricks.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <seabios-bounces@seabios.org>
Content-Disposition: inline
In-Reply-To: <20131104105149.GB30503@dhcp-192-168-178-175.profitbricks.localdomain>
List-Unsubscribe: <http://www.seabios.org/mailman/options/seabios>,
 <mailto:seabios-request@seabios.org?subject=unsubscribe>
List-Archive: <http://www.seabios.org/pipermail/seabios>
List-Post: <mailto:seabios@seabios.org>
List-Help: <mailto:seabios-request@seabios.org?subject=help>
List-Subscribe: <http://www.seabios.org/mailman/listinfo/seabios>,
 <mailto:seabios-request@seabios.org?subject=subscribe>
Errors-To: seabios-bounces@seabios.org
Sender: seabios-bounces@seabios.org
To: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Cc: rjw@sisk.pl, linux-acpi@vger.kernel.org, thilo.fromm@profitbricks.com, seabios@seabios.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 04, 2013 at 11:51:49AM +0100, Vasilis Liaskovitis wrote:
> Any comment on this?
> 
> On Fri, Oct 25, 2013 at 11:32:10AM +0200, Vasilis Liaskovitis wrote:
> > This patch adds a _PXM object to seabios CPU objects. The _PXM value is derived
> > from CPU SRAT entries, so build_ssdt needs to be called after build_srat for
> > this to work.

I think ACPI changes should be done at QEMU.  Going forward, QEMU will
pass the tables into SeaBIOS.

-Kevin
