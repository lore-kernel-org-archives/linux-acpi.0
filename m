From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [ACPI] Re: status update for current
	development on ASUS M2N
Date: Mon, 27 Sep 2004 23:29:57 +1000
Sender: softwaresuspend-devel-admin@berlios.de
Message-ID: <1096291797.4222.49.camel@laptop.cunninghams>
References: <m3lleww12c.fsf@brain.gnuhh.org>
	 <20040927123320.GA28634@hell.org.pl>  <m3d607g7st.fsf@brain.gnuhh.org>
Reply-To: ncunningham@linuxmail.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <softwaresuspend-devel-admin@lists.berlios.de>
In-Reply-To: <m3d607g7st.fsf@brain.gnuhh.org>
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

On Mon, 2004-09-27 at 23:28, Georg C. F. Greve wrote:
>  || On Mon, 27 Sep 2004 14:33:20 +0200
>  || Karol Kozimor <sziwan@hell.org.pl> wrote: 
> 
>  kk> I had that issue too, with 2.6.9-rc1 I s'pose, but I thought it
>  kk> was just bug #3193 revisited and didn't really investigate. Does
>  kk> changing swsusp2 to _not_ use ACPI S4 help?
> 
> It seems that this is not a compile-time option anymore and solely
> determined by /proc/software_suspend/acpi_s4_support, right?

That's right.

Regards,

Nigel

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.
