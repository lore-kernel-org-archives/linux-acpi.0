From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: status update for current development
	on ASUS M2N
Date: Wed, 06 Oct 2004 09:44:23 +1000
Sender: softwaresuspend-devel-admin@berlios.de
Message-ID: <1097019863.16541.47.camel@desktop.cunninghams>
References: <20040930214808.B5D9C3AA515@ws5-8.us4.outblaze.com>
	 <m3ekkiqdcy.fsf@brain.gnuhh.org>
Reply-To: ncunningham@linuxmail.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <softwaresuspend-devel-admin@lists.berlios.de>
In-Reply-To: <m3ekkiqdcy.fsf@brain.gnuhh.org>
Errors-To: softwaresuspend-devel-admin@berlios.de
List-Help: <mailto:softwaresuspend-devel-request@lists.berlios.de?subject=help>
List-Post: <mailto:softwaresuspend-devel@lists.berlios.de>
List-Subscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-devel>,
	<mailto:softwaresuspend-devel-request@lists.berlios.de?subject=subscribe>
List-Unsubscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-devel>,
	<mailto:softwaresuspend-devel-request@lists.berlios.de?subject=unsubscribe>
List-Archive: <http://lists.berlios.de/pipermail/softwaresuspend-devel/>
To: "Georg C. F. Greve" <greve@gnu.org>
Cc: ACPI List <acpi-devel@lists.sourceforge.net>, SoftwareSuspend-Devel <softwaresuspend-devel@lists.berlios.de>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Sat, 2004-10-02 at 08:31, Georg C. F. Greve wrote:
>  || On Fri, 01 Oct 2004 07:48:08 +1000
>  || "Nigel Cunningham" <ncunningham@linuxmail.org> wrote: 
> 
>  >> Can you tell me how to do this, please?
> 
>  nc> The simplest way is to do a digital photograph, I'm afraid. The
>  nc> 'nice' way is to hook up a serial console and capture the output.
> 
> That is rather inconvenient.
> 
> I'm curious. Any reason that nobody implemented something to do this?
> 
> I would assume that a kdb buffer that is reserved at startup,
> initalized with 0s and into which only kdb can write during debugging.
> 
> When kdb is left and the buffer is different from 0, the contents are
> dumped to dmesg/syslog.

Something like printk :> It wouldn't work with suspending because we're
overwriting such buffers when copying the original kernel back (with the
contents from suspend-time). Furthermore, it won't help if you get such
a crash because you're never going to start syslogd and get the data
written.

Sorry.

Nigel
