From: Michael Buesch <mb-fseUSCV1ubazQB+pC5nmwQ@public.gmane.org>
Subject: Re: 64-bit DMA problems with BCM4312 using b43
Date: Fri, 13 Nov 2009 21:44:21 +0100
Message-ID: <200911132144.24110.mb@bu3sch.de>
References: <4AFD958E.1000303@lwfinger.net>
	<20091113201112.GA5540@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <bcm43xx-dev-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <20091113201112.GA5540-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.berlios.de/mailman/listinfo/bcm43xx-dev>,
	<mailto:bcm43xx-dev-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/bcm43xx-dev>
List-Post: <mailto:bcm43xx-dev-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:bcm43xx-dev-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/bcm43xx-dev>,
	<mailto:bcm43xx-dev-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: bcm43xx-dev-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: bcm43xx-dev-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: bcm43xx-dev-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Larry Finger <Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Friday 13 November 2009 21:11:12 Matthew Garrett wrote:
> On Fri, Nov 13, 2009 at 11:21:18AM -0600, Larry Finger wrote:
> 
> > I do not know enough about either the ACPI or DMA code to begin debugging in
> > either of those regions. Any suggestions on debugging strategies, or links to
> > similar problems would be appreciated.
> 
> Could the hardware be highly sensitive to DMA latencies? Take a look at 
> the pm_qos code in ipw2100.

This makes perfect sense, yes. The DMA engine has so many quirks, I wouldn't be
surprised if it couldn't handle pm properly.

-- 
Greetings, Michael.
