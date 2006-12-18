From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: suspend to RAM on lifebook 7110
Date: Mon, 18 Dec 2006 12:05:51 +0000
Message-ID: <20061218120551.GA27546@srcf.ucam.org>
References: <20061208123358.GA3724@invalid.invalid>
	<20061208211308.GA5157@erebor.ics.muni.cz>
	<20061218065136.GG26170@suse.de>
	<20061218111142.GA27070@srcf.ucam.org>
	<20061218112916.GB6636@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20061218112916.GB6636@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Stefan Seyfried <seife@suse.de>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, linux-acpi@vger.kernel.org, Miroslav Ruda <ruda@ics.muni.cz>
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 18, 2006 at 12:29:16PM +0100, Stefan Seyfried wrote:
> So the question is: should we either
>  - implement a minimal "graphics card PCI suspend resume" "driver" in the
>    kernel that will do this even if no framebuffer is used, or

The long term aim is to implement a thin graphics card driver in the 
kernel, and then port framebuffer and DRM code to that. Doing it 
effectively requires knowing which PCI configuration registers are 
relevant for the hardware, which is possibly easier said than done.

>  - implement this as a workaround in userspace?

Might be easier for the moment, though I agree that it's less than 
ideal.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
